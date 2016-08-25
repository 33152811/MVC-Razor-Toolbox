@using $rootnamespace$.Helpers.Razor
@using $rootnamespace$.Helpers.Razor.HtmlExtensions
@model object

@{
    ViewBag.kind = ViewBag.kind ?? "raw";

    if (ViewBag.kind != "raw" && ViewBag.kind != "form-group")
    {
        throw new Exception("Unknown kind " + ViewBag.kind);
    }

    var value = ViewBag.value ?? Model;
    var debugAttribute = HttpContext.Current.IsDebuggingEnabled ? ViewData.ModelMetadata.ModelType.Name : null;
}

@if (ViewBag.kind == "raw")
{
    <div class="@ViewBag.valueClass" @if (debugAttribute != null) { <text>data-displaytemplate-type="@debugAttribute"</text> }>
        @value

        @if (ViewBag.suffix != null)
        {
            @ViewBag.suffix
        }
    </div>
}
else if (ViewBag.kind == "form-group")
{
    <div class="form-group@(Html.ValidationErrorFor(m => m, " has-error"))">
        @Html.LabelFor(m => m, new { @class = HtmlClasses.Label })

        <div class="controls @HtmlClasses.ControlRaw @ViewBag.valueClass">
            @value

            @if (ViewBag.suffix != null)
            {
                @ViewBag.suffix
            }
        </div>
    </div>
}
